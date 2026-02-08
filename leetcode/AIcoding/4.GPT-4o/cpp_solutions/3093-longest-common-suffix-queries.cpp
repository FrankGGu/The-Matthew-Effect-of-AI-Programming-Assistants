class SuffixArray {
public:
    vector<int> suffixArray;
    vector<int> rank;
    string str;

    SuffixArray(const string &s) : str(s) {
        int n = str.size();
        suffixArray.resize(n);
        rank.resize(n);
        vector<int> temp(n), cnt(max(256, n), 0);

        for (int i = 0; i < n; ++i) {
            cnt[str[i]]++;
        }
        for (int i = 1; i < cnt.size(); ++i) {
            cnt[i] += cnt[i - 1];
        }
        for (int i = 0; i < n; ++i) {
            suffixArray[--cnt[str[i]]] = i;
        }

        rank[suffixArray[0]] = 0;
        for (int i = 1; i < n; ++i) {
            rank[suffixArray[i]] = rank[suffixArray[i - 1]] + (str[suffixArray[i]] != str[suffixArray[i - 1]]);
        }

        for (int len = 1; len < n; len <<= 1) {
            vector<int> newSuffixArray(n), newRank(n);
            fill(cnt.begin(), cnt.begin() + rank[suffixArray.back()] + 1, 0);
            for (int i = 0; i < n; ++i) {
                cnt[rank[i]]++;
            }
            for (int i = 1; i <= rank[suffixArray.back()]; ++i) {
                cnt[i] += cnt[i - 1];
            }
            for (int i = n - 1; i >= 0; --i) {
                int nextRank = (suffixArray[i] + len < n) ? rank[suffixArray[i] + len] : -1;
                newSuffixArray[--cnt[rank[suffixArray[i]]]] = suffixArray[i];
            }
            suffixArray = newSuffixArray;

            newRank[suffixArray[0]] = 0;
            for (int i = 1; i < n; ++i) {
                newRank[suffixArray[i]] = newRank[suffixArray[i - 1]] + (rank[suffixArray[i]] != rank[suffixArray[i - 1]] || 
                    (suffixArray[i] + len < n && suffixArray[i - 1] + len < n && rank[suffixArray[i] + len] != rank[suffixArray[i - 1] + len]));
            }
            rank = newRank;
        }
    }

    int lcp(int x, int y) {
        int res = 0;
        for (int len = str.size() - x; len > 0 && len > str.size() - y; ) {
            if (str[x] == str[y]) {
                res++;
                x++;
                y++;
                len--;
            } else {
                break;
            }
        }
        return res;
    }
};

class Solution {
public:
    vector<int> longestCommonSuffixQueries(string s, vector<vector<int>>& queries) {
        SuffixArray sa(s);
        int n = queries.size();
        vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            result[i] = sa.lcp(queries[i][0], queries[i][1]);
        }
        return result;
    }
};