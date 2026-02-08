class Solution {
    public int minNumberOfFrogs(String croakOfFrogs) {
        int cCount = 0;
        int rCount = 0;
        int oCount = 0;
        int aCount = 0;
        int kCount = 0;

        int activeFrogs = 0;
        int maxFrogs = 0;

        for (char ch : croakOfFrogs.toCharArray()) {
            switch (ch) {
                case 'c':
                    cCount++;
                    activeFrogs++;
                    maxFrogs = Math.max(maxFrogs, activeFrogs);
                    break;
                case 'r':
                    rCount++;
                    if (rCount > cCount) {
                        return -1;
                    }
                    break;
                case 'o':
                    oCount++;
                    if (oCount > rCount) {
                        return -1;
                    }
                    break;
                case 'a':
                    aCount++;
                    if (aCount > oCount) {
                        return -1;
                    }
                    break;
                case 'k':
                    kCount++;
                    if (kCount > aCount) {
                        return -1;
                    }
                    activeFrogs--; 
                    break;
                default:
                    return -1; // Should not happen based on problem constraints
            }
        }

        if (cCount != kCount) {
            return -1;
        }

        return maxFrogs;
    }
}