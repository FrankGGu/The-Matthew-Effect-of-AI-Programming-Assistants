class Solution {
public:
    string complexNumberMultiply(string num1, string num2) {
        auto parse = [](const string& num) -> pair<int, int> {
            int plus_pos = num.find('+');
            int real = stoi(num.substr(0, plus_pos));
            int imaginary = stoi(num.substr(plus_pos + 1, num.size() - plus_pos - 2));
            return {real, imaginary};
        };

        auto [a, b] = parse(num1);
        auto [c, d] = parse(num2);

        int real_part = a * c - b * d;
        int imag_part = a * d + b * c;

        return to_string(real_part) + "+" + to_string(imag_part) + "i";
    }
};