#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
private:
    class FenwickTree {
    private:
        std::vector<int> bit;
        int size;
    public:
        FenwickTree(int n) : size(n), bit(n + 1, 0) {}

        void add(int index, int delta) {
            for (; index <= size; index += index & -index) {
                bit[index] += delta;
            }
        }

        int query(int index) {
            int sum = 0;
            for (; index > 0; index -= index & -index) {
                sum += bit[index];
            }
            return sum;
        }
    };

    long long solve(const std::string& word, int k) {
        int n = word.length();
        if (k < 0) {
            return 0;
        }

        auto is_vowel = [](char c) {
            return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
        };

        std::vector<int> C(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            C[i + 1] = C[i] + (is_vowel(word[i]) ? 0 : 1);
        }

        std::vector<int> min_last_pos(n, -1);
        std::vector<int> last_pos_v(5, -1);
        std::string vowels = "aeiou";
        std::unordered_map<char, int> vowel_to_idx;
        for (int i = 0; i < 5; ++i) {
            vowel_to_idx[vowels[i]] = i;
        }

        for (int i = 0; i < n; ++i) {
            if (is_vowel(word[i])) {
                last_pos_v[vowel_to_idx.at(word[i])] = i;
            }
            int current_min = n;
            for (int pos : last_pos_v) {
                current_min = std::min(current_min, pos);
            }
            min_last_pos[i] = current_min;
        }

        long long count = 0;
        FenwickTree ft(n + 2);
        int l_ptr = 0;

        for (int r = 0; r < n; ++r) {
            int max_l = min_last_pos[r];
            if (max_l == -1) {
                continue;
            }

            while (l_ptr <= max_l) {
                ft.add(C[l_ptr] + 1, 1);
                l_ptr++;
            }

            int min_C_l = C[r + 1] - k;
            int count_less = 0;
            if (min_C_l > 0) {
                count_less = ft.query(min_C_l);
            }
            count += (l_ptr - count_less);
        }
        return count;
    }

public:
    long long countSubstrings(std::string word, int k) {
        return solve(word, k) - solve(word, k - 1);
    }
};