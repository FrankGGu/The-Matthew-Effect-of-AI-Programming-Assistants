#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minStickers(vector<string>& stickers, string target) {
        vector<int> targetCount(26, 0);
        for (char c : target) {
            targetCount[c - 'a']++;
        }

        vector<vector<int>> stickerCounts;
        for (const string& s : stickers) {
            vector<int> count(26, 0);
            for (char c : s) {
                count[c - 'a']++;
            }
            stickerCounts.push_back(count);
        }

        unordered_map<string, int> memo;
        return dfs(stickerCounts, targetCount, memo);
    }

private:
    int dfs(vector<vector<int>>& stickers, vector<int>& target, unordered_map<string, int>& memo) {
        string key;
        for (int i = 0; i < 26; ++i) {
            key += to_string(target[i]) + ",";
        }

        if (memo.find(key) != memo.end()) {
            return memo[key];
        }

        int res = INT_MAX;
        bool isDone = true;
        for (int i = 0; i < 26; ++i) {
            if (target[i] > 0) {
                isDone = false;
                break;
            }
        }
        if (isDone) {
            return 0;
        }

        for (const vector<int>& sticker : stickers) {
            bool hasChar = false;
            for (int i = 0; i < 26; ++i) {
                if (sticker[i] > 0 && target[i] > 0) {
                    hasChar = true;
                    break;
                }
            }
            if (!hasChar) continue;

            vector<int> newTarget = target;
            for (int i = 0; i < 26; ++i) {
                if (sticker[i] > 0 && newTarget[i] > 0) {
                    newTarget[i] -= sticker[i];
                }
            }

            int next = dfs(stickers, newTarget, memo);
            if (next != INT_MAX) {
                res = min(res, 1 + next);
            }
        }

        memo[key] = res;
        return res;
    }
};