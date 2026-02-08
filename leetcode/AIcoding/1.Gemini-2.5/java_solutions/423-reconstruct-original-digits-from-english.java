import java.util.HashMap;
import java.util.Map;
import java.util.Arrays;

class Solution {
    public String originalDigits(String s) {
        int[] charCounts = new int[26];
        for (char c : s.toCharArray()) {
            charCounts[c - 'a']++;
        }

        int[] digitCounts = new int[10];

        // Deduce unique digits first
        // zero is the only digit with 'z'
        digitCounts[0] = charCounts['z' - 'a'];
        // two is the only digit with 'w'
        digitCounts[2] = charCounts['w' - 'a'];
        // four is the only digit with 'u'
        digitCounts[4] = charCounts['u' - 'a'];
        // six is the only digit with 'x'
        digitCounts[6] = charCounts['x' - 'a'];
        // eight is the only digit with 'g'
        digitCounts[8] = charCounts['g' - 'a'];

        // Deduce digits using characters that become unique after removing the first set
        // three has 'h', and eight also has 'h'. After counting eight, 'h' is unique for three.
        digitCounts[3] = charCounts['h' - 'a'] - digitCounts[8];
        // five has 'f', and four also has 'f'. After counting four, 'f' is unique for five.
        digitCounts[5] = charCounts['f' - 'a'] - digitCounts[4];
        // seven has 's', and six also has 's'. After counting six, 's' is unique for seven.
        digitCounts[7] = charCounts['s' - 'a'] - digitCounts[6];

        // Deduce remaining digits
        // one has 'o', and zero, two, four also have 'o'. After counting 0, 2, 4, 'o' is unique for one.
        digitCounts[1] = charCounts['o' - 'a'] - digitCounts[0] - digitCounts[2] - digitCounts[4];
        // nine has 'i', and five, six, eight also have 'i'. After counting 5, 6, 8, 'i' is unique for nine.
        digitCounts[9] = charCounts['i' - 'a'] - digitCounts[5] - digitCounts[6] - digitCounts[8];

        // Construct the result string
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i <= 9; i++) {
            for (int j = 0; j < digitCounts[i]; j++) {
                sb.append(i);
            }
        }

        return sb.toString();
    }
}