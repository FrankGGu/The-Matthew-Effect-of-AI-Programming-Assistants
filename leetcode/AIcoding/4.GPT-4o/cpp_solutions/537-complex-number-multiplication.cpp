class Solution {
public:
    string complexNumberMultiply(string num1, string num2) {
        int a = stoi(num1.substr(0, num1.find('+')));
        int b = stoi(num1.substr(num1.find('+') + 1, num1.size() - num1.find('+') - 2));
        int c = stoi(num2.substr(0, num2.find('+')));
        int d = stoi(num2.substr(num2.find('+') + 1, num2.size() - num2.find('+') - 2));

        return to_string(a * c - b * d) + "+" + to_string(a * d + b * c) + "i";
    }
};