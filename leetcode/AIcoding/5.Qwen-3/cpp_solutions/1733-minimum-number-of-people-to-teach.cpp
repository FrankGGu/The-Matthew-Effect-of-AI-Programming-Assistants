#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minPeopleToTeach(vector<string>& languages, vector<vector<int>>& friendships) {
        unordered_map<int, vector<int>> languageToUsers;
        for (int i = 0; i < languages.size(); ++i) {
            for (char c : languages[i]) {
                languageToUsers[c - 'a'].push_back(i);
            }
        }

        vector<bool> taught(languages.size(), false);
        for (auto& pair : languageToUsers) {
            if (pair.second.size() > 1) {
                for (int user : pair.second) {
                    taught[user] = true;
                }
            }
        }

        int result = 0;
        for (int i = 0; i < friendships.size(); ++i) {
            int u = friendships[i][0];
            int v = friendships[i][1];
            bool uKnows = false;
            bool vKnows = false;
            for (char c : languages[u]) {
                if (languageToUsers[c - 'a'].size() > 1) {
                    uKnows = true;
                    break;
                }
            }
            for (char c : languages[v]) {
                if (languageToUsers[c - 'a'].size() > 1) {
                    vKnows = true;
                    break;
                }
            }
            if (!uKnows && !vKnows) {
                result++;
            }
        }

        return result;
    }
};