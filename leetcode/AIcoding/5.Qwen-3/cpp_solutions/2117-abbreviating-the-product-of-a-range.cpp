#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    string abbreviateProduct(string& product, int k) {
        long long numerator = 1;
        long long denominator = 1;
        int count5 = 0;
        int count2 = 0;
        int len = product.length();
        int left = 0;
        int right = 0;

        for (int i = 0; i < len; ++i) {
            if (product[i] == '-') {
                left = i + 1;
            } else if (product[i] == ' ') {
                right = i;
                break;
            }
        }

        int start = stoi(product.substr(0, left - 1));
        int end = stoi(product.substr(right + 1, len - right - 1));

        for (int i = start; i <= end; ++i) {
            int x = i;
            while (x % 5 == 0) {
                x /= 5;
                ++count5;
            }
            while (x % 2 == 0) {
                x /= 2;
                ++count2;
            }
            numerator *= x;
            if (numerator > 1e18) {
                denominator *= 10;
                numerator /= 10;
            }
        }

        int zeros = min(count5, count2);
        count2 -= zeros;
        count5 -= zeros;

        long long power = 1;
        for (int i = 0; i < count2; ++i) {
            power *= 2;
        }
        for (int i = 0; i < count5; ++i) {
            power *= 5;
        }

        numerator *= power;

        string result;
        long long temp = numerator;
        while (temp > 0) {
            result.push_back('0' + temp % 10);
            temp /= 10;
        }
        reverse(result.begin(), result.end());

        if (result.length() > k) {
            return result.substr(0, k) + "e" + to_string(zeros);
        } else {
            return result + "e" + to_string(zeros);
        }
    }
};