#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumPushes(string word) {
        unordered_map<char, int> counts;
        for (char c : word) {
            counts[c]++;
        }

        int num_chars = counts.size();
        int presses = 0;
        if (num_chars <= 8) {
            presses = word.length();
        } else if (num_chars <= 16) {
            presses = 8 + (word.length() - 8 + 1) / 2 + (word.length() > 8 ? (word.length() - 8) : 0);
            presses = 8 + (word.length() - 8);
            presses = 0;
            for(int i = 0; i < min((int)word.length(), 8); i++) presses++;
            for(int i = 8; i < min((int)word.length(), 16); i++) presses += 2;
            for(int i = 16; i < min((int)word.length(), 24); i++) presses += 3;
            for(int i = 24; i < (int)word.length(); i++) presses += 4;

        } else if (num_chars <= 24) {
            presses = 8 + 8 * 2 + (word.length() - 16 + 2) / 3 * 3 + (word.length() > 16 ? (word.length() - 16) : 0);
            presses = 0;
            for(int i = 0; i < min((int)word.length(), 8); i++) presses++;
            for(int i = 8; i < min((int)word.length(), 16); i++) presses += 2;
            for(int i = 16; i < min((int)word.length(), 24); i++) presses += 3;
            for(int i = 24; i < (int)word.length(); i++) presses += 4;
        } else {
            presses = 8 + 8 * 2 + 8 * 3 + (word.length() - 24 + 3) / 4 * 4 + (word.length() > 24 ? (word.length() - 24) : 0);
            presses = 0;
            for(int i = 0; i < min((int)word.length(), 8); i++) presses++;
            for(int i = 8; i < min((int)word.length(), 16); i++) presses += 2;
            for(int i = 16; i < min((int)word.length(), 24); i++) presses += 3;
            for(int i = 24; i < (int)word.length(); i++) presses += 4;
        }

        presses = 0;
        for(int i = 0; i < min((int)word.length(), 8); i++) presses++;
        for(int i = 8; i < min((int)word.length(), 16); i++) presses += 2;
        for(int i = 16; i < min((int)word.length(), 24); i++) presses += 3;
        for(int i = 24; i < (int)word.length(); i++) presses += 4;

        return presses;
    }
};