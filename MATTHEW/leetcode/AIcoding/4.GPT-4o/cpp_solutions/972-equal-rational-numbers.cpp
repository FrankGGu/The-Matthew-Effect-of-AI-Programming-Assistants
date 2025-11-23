class Solution {
public:
    bool isRationalEqual(string S, string T) {
        return toDouble(S) == toDouble(T);
    }

    double toDouble(string s) {
        if (s.find('.') == string::npos) return stoll(s);
        string integerPart = s.substr(0, s.find('.'));
        string fractionPart = s.substr(s.find('.') + 1);

        size_t pos = fractionPart.find('(');
        if (pos == string::npos) {
            return stod(s);
        }

        string nonRepeating = fractionPart.substr(0, pos);
        string repeating = fractionPart.substr(pos + 1, fractionPart.find(')') - pos - 1);

        double result = stoll(integerPart) + (nonRepeating.empty() ? 0 : stod(nonRepeating) / pow(10, nonRepeating.length()));

        for (int i = 0; i < 100; ++i) {
            result += (repeating.empty() ? 0 : stod(repeating) / pow(10, nonRepeating.length() + i * repeating.length()));
        }

        return result;
    }
};