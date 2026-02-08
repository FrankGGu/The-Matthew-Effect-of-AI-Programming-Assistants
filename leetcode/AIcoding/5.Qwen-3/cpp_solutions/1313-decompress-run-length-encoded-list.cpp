#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> decompressRLEnlisted(vector<int>& head) {
        vector<int> result;
        for (int i = 0; i < head.size(); i += 2) {
            int freq = head[i];
            int val = head[i + 1];
            for (int j = 0; j < freq; ++j) {
                result.push_back(val);
            }
        }
        return result;
    }
};