import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<String> findRepeatedDnaSequences(String s) {
        List<String> result = new ArrayList<>();
        if (s.length() < 10) {
            return result;
        }

        int[] charToInt = new int[26];
        charToInt['A' - 'A'] = 0; // 00
        charToInt['C' - 'A'] = 1; // 01
        charToInt['G' - 'A'] = 2; // 10
        charToInt['T' - 'A'] = 3; // 11

        Set<Integer> seen = new HashSet<>();
        Set<Integer> repeatedHashes = new HashSet<>();

        int currentHash = 0;
        // Calculate initial hash for the first 10 characters s[0...9]
        for (int j = 0; j < 10; j++) {
            currentHash = (currentHash << 2) | charToInt[s.charAt(j) - 'A'];
        }
        seen.add(currentHash);

        // Loop for subsequent hashes using a rolling hash
        // The window shifts from s[i-1...i+8] to s[i...i+9]
        // i+9 is the new character entering the window
        // (1 << 20) - 1 is a mask to keep only the last 20 bits (10 chars * 2 bits/char)
        int mask = (1 << 20) - 1; 
        for (int i = 1; i <= s.length() - 10; i++) {
            currentHash = (currentHash << 2) & mask;
            currentHash |= charToInt[s.charAt(i + 9) - 'A'];

            if (seen.contains(currentHash)) {
                if (repeatedHashes.add(currentHash)) {
                    result.add(s.substring(i, i + 10));
                }
            } else {
                seen.add(currentHash);
            }
        }

        return result;
    }
}