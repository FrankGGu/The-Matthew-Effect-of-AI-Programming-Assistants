#include <string>
#include <vector>
#include <queue>
#include <unordered_set>
#include <unordered_map>
#include <algorithm>
#include <functional> // For std::function

class Solution {
public:
    std::vector<std::vector<std::string>> findLadders(std::string beginWord, std::string endWord, std::vector<std::string>& wordList) {
        std::vector<std::vector<std::string>> results;

        std::unordered_set<std::string> wordSet(wordList.begin(), wordList.end());

        if (wordSet.find(endWord) == wordSet.end()) {
            return results;
        }

        // Add beginWord to wordSet if it's not already there.
        // This ensures it can be processed by the BFS for neighbor generation
        // and its neighbors can be checked against the set.
        // If beginWord is not in wordList, it's still a valid starting point.
        bool beginWordNotInList = (wordSet.find(beginWord) == wordSet.end());
        if (beginWordNotInList) {
            wordSet.insert(beginWord);
        }

        std::unordered_map<std::string, int> dist; // Shortest distance from beginWord
        std::unordered_map<std::string, std::vector<std::string>> parentMap; // child -> list of parents
        std::queue<std::string> q;

        q.push(beginWord);
        dist[beginWord] = 0;
        bool foundEnd = false;

        while (!q.empty()) {
            int levelSize = q.size();
            std::unordered_set<std::string> visitedInCurrentLevel; // Words discovered in the current level

            for (int i = 0; i < levelSize; ++i) {
                std::string curr = q.front();
                q.pop();

                if (curr == endWord) {
                    foundEnd = true;
                }

                std::string temp = curr;
                for (int j = 0; j < temp.length(); ++j) {
                    char originalChar = temp[j];
                    for (char c = 'a'; c <= 'z'; ++c) {
                        temp[j] = c;
                        if (temp == curr) continue; 

                        // Check if 'temp' is a valid word and hasn't been visited at an earlier level.
                        // wordSet acts as a pool of unvisited words for current/future levels.
                        if (wordSet.count(temp)) {
                            // If 'temp' is not yet visited, or visited at the same distance (multiple shortest paths)
                            if (dist.find(temp) == dist.end()) { // First time visiting 'temp'
                                dist[temp] = dist[curr] + 1;
                                parentMap[temp].push_back(curr);
                                visitedInCurrentLevel.insert(temp); // Mark for next level's queue
                            } else if (dist[temp] == dist[curr] + 1) { // 'temp' already visited at same level
                                parentMap[temp].push_back(curr);
                            }
                            // If dist[temp] < dist[curr] + 1, it means a shorter path to 'temp' was found earlier, so ignore this path.
                        }
                    }
                    temp[j] = originalChar; // Restore original character
                }
            }

            // After processing all nodes in this level, add newly discovered nodes to the queue for the next level.
            // Remove them from wordSet to prevent them from being visited again from later levels (longer paths).
            for (const std::string& word : visitedInCurrentLevel) {
                q.push(word);
                wordSet.erase(word); 
            }

            if (foundEnd) {
                break; // Shortest path to endWord found, stop BFS
            }
        }

        // If endWord was not reachable, return empty results
        if (!foundEnd) {
            return results;
        }

        // DFS to reconstruct all shortest paths
        std::vector<std::string> currentPath;
        std::function<void(const std::string&)> dfs = 
            [&](const std::string& word) {
            currentPath.push_back(word);
            if (word == beginWord) {
                std::reverse(currentPath.begin(), currentPath.end());
                results.push_back(currentPath);
                std::reverse(currentPath.begin(), currentPath.end()); // Backtrack: restore path for other branches
            } else {
                for (const std::string& parent : parentMap[word]) {
                    dfs(parent);
                }
            }
            currentPath.pop_back(); // Backtrack
        };

        dfs(endWord);

        return results;
    }
};