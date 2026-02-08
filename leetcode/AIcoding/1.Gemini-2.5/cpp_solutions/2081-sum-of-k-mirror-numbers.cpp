#include <string>
#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    bool isPalindrome(long long n, int base) {
        if (base == 1) {
            // In a unary (base-1) system, a number N is represented by N copies of the single digit (e.g., '1').
            // For example, 3 in base-1 is "111". Any such representation is a palindrome.
            // This assumes positive integers.
            return true;
        }
        if (n == 0) return true; 

        std::vector<int> digits;
        long long temp = n;
        while (temp > 0) {
            digits.push_back(temp % base);
            temp /= base;
        }

        int left = 0;
        int right = digits.size() - 1;
        while (left < right) {
            if (digits[left] != digits[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    long long createPalindrome(long long root, bool isOddLength) {
        std::string s = std::to_string(root);
        std::string reversed_s = s;
        std::reverse(reversed_s.begin(), reversed_s.end());

        if (isOddLength) {
            return std::stoll(s + reversed_s.substr(1));
        } else {
            return std::stoll(s + reversed_s);
        }
    }

    long long sumOfKMirrorNumbers(int k, int n) {
        std::set<long long> candidatePalindromes;
        long long root = 1;

        // Generate base-10 palindromes.
        // The largest k-mirror number for n=30, k=2 is 1302021 (from root 13020, odd length).
        // A root limit of 200,000 is sufficiently generous to cover all cases for n=30.
        // This generates palindromes up to 12 digits (e.g., 200000000000 for even length).
        // Total candidates: approx. 2 * 200,000 = 400,000.
        // Each candidate check involves base conversion and palindrome check, which is fast.
        const long long ROOT_LIMIT = 200000; 

        while (root <= ROOT_LIMIT) {
            long long p_odd = createPalindrome(root, true);
            if (p_odd > 0) {
                candidatePalindromes.insert(p_odd);
            }

            long long p_even = createPalindrome(root, false);
            if (p_even > 0) {
                candidatePalindromes.insert(p_even);
            }
            root++;
        }

        long long totalSum = 0;
        int count = 0;
        for (long long num : candidatePalindromes) {
            if (isPalindrome(num, k)) {
                totalSum += num;
                count++;
                if (count == n) {
                    break;
                }
            }
        }

        return totalSum;
    }
};