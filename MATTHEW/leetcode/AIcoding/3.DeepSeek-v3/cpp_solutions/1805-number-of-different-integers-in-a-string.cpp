class Solution {
public:
    int numDifferentIntegers(string word) {
        unordered_set<string> nums;
        int n = word.size();
        for (int i = 0; i < n; ) {
            if (isdigit(word[i])) {
                string num;
                while (i < n && isdigit(word[i])) {
                    if (num.empty() && word[i] == '0') {
                        i++;
                    } else {
                        num += word[i++];
                    }
                }
                if (num.empty()) {
                    nums.insert("0");
                } else {
                    nums.insert(num);
                }
            } else {
                i++;
            }
        }
        return nums.size();
    }
};