class Solution {
    public int longestSubstringOfAllVowels(String word) {
        int maxLen = 0;
        int currentLen = 0;
        int expectedVowelIndex = 0; 
        int vowelsFoundMask = 0; 

        for (char c : word.toCharArray()) {
            int cVowelIdx = -1;
            switch (c) {
                case 'a': cVowelIdx = 0; break;
                case 'e': cVowelIdx = 1; break;
                case 'i': cVowelIdx = 2; break;
                case 'o': cVowelIdx = 3; break;
                case 'u': cVowelIdx = 4; break;
                default:
                    currentLen = 0;
                    expectedVowelIndex = 0;
                    vowelsFoundMask = 0;
                    continue; 
            }

            if (cVowelIdx == expectedVowelIndex) {
                currentLen++;
                vowelsFoundMask |= (1 << cVowelIdx);
            } else if (cVowelIdx == expectedVowelIndex + 1) {
                currentLen++;
                expectedVowelIndex++;
                vowelsFoundMask |= (1 << cVowelIdx);
            } else {
                if (cVowelIdx == 0) {
                    currentLen = 1;
                    expectedVowelIndex = 0;
                    vowelsFoundMask = (1 << 0);
                } else {
                    currentLen = 0;
                    expectedVowelIndex = 0; 
                    vowelsFoundMask = 0;
                }
            }

            if (vowelsFoundMask == 0b11111) { 
                maxLen = Math.max(maxLen, currentLen);
            }
        }

        return maxLen;
    }
}