class Solution {
public:
    bool canBeEqual(string target, string arr) {
        sort(target.begin(), target.end());
        sort(arr.begin(), arr.end());
        return target == arr;
    }
};