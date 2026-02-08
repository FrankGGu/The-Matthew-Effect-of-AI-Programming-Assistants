#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    Solution() : max_len(0) {}

    int longestUploadedPrefix() {
        return max_len;
    }

    void upload(int videoId) {
        uploaded.insert(videoId);
        while (uploaded.find(max_len + 1) != uploaded.end()) {
            max_len++;
        }
    }

private:
    unordered_set<int> uploaded;
    int max_len;
};