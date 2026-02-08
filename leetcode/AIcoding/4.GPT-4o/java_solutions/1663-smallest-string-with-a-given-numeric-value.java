class Solution {
    public String smallestString(int n, int k) {
        StringBuilder result = new StringBuilder();
        k -= n; // Adjust k by subtracting n since 'a' contributes 1 to the sum
        for (int i = 0; i < n; i++) {
            char ch = 'a'; // Start with 'a'
            if (k > 0) {
                int add = Math.min(25, k); // Max we can add is 25 to reach 'z'
                ch += add; // Adjust the character
                k -= add; // Decrease k accordingly
            }
            result.append(ch); // Append the character to the result
        }
        return result.toString();
    }
}