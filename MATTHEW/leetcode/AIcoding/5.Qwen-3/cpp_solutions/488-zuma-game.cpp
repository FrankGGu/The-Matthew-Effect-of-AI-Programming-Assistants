#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int findMinStep(string board, string hand) {
        unordered_map<char, int> handCount;
        for (char c : hand) {
            handCount[c]++;
        }

        queue<pair<string, unordered_map<char, int>>> q;
        q.push({board, handCount});

        unordered_map<string, int> visited;

        while (!q.empty()) {
            auto [currentBoard, currentHand] = q.front();
            q.pop();

            if (visited.find(currentBoard) != visited.end() && visited[currentBoard] <= 0) {
                continue;
            }

            if (currentBoard.empty()) {
                return 0;
            }

            for (int i = 0; i < currentBoard.length(); ++i) {
                for (auto& [c, count] : currentHand) {
                    if (count == 0) continue;

                    string newBoard = currentBoard;
                    newBoard.insert(i, 1, c);
                    int steps = 0;

                    while (true) {
                        bool hasRemoved = false;
                        string temp;
                        int j = 0;
                        while (j < newBoard.length()) {
                            int k = j;
                            while (k < newBoard.length() && newBoard[k] == newBoard[j]) {
                                k++;
                            }
                            if (k - j >= 3) {
                                hasRemoved = true;
                            } else {
                                temp += newBoard.substr(j, k - j);
                            }
                            j = k;
                        }
                        if (!hasRemoved) break;
                        newBoard = temp;
                    }

                    if (newBoard.empty()) {
                        return 1;
                    }

                    currentHand[c]--;
                    q.push({newBoard, currentHand});
                    currentHand[c]++;
                }
            }

            visited[currentBoard] = 0;
        }

        return -1;
    }
};