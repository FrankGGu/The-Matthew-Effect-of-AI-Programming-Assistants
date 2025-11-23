class Solution {
    public int minNumberOfFrogs(String croakOfFrogs) {
        int[] count = new int[5];
        int frogs = 0, maxFrogs = 0;
        for (char c : croakOfFrogs.toCharArray()) {
            int index = "croak".indexOf(c);
            count[index]++;
            if (index == 0) {
                frogs++;
                maxFrogs = Math.max(maxFrogs, frogs);
            } else {
                count[index - 1]--;
                if (count[index - 1] < 0) {
                    return -1;
                }
                if (index == 4) {
                    frogs--;
                }
            }
        }
        return frogs == 0 ? maxFrogs : -1;
    }
}