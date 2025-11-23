class Solution {
public:
    vector<string> findValidSerials(vector<string>& serials) {
        unordered_set<string> validSerials;
        for (const auto& serial : serials) {
            if (isValid(serial)) {
                validSerials.insert(serial);
            }
        }
        return vector<string>(validSerials.begin(), validSerials.end());
    }

private:
    bool isValid(const string& serial) {
        if (serial.length() != 10) return false;
        for (int i = 0; i < 10; ++i) {
            if (!isalnum(serial[i])) return false;
        }
        return true;
    }
};