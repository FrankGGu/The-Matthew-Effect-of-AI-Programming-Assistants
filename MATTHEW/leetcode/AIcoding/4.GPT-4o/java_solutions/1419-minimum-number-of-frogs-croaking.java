public class Solution {
    public int minNumberOfFrogs(String croakOfFrogs) {
        int[] count = new int[5];
        int frogs = 0, maxFrogs = 0;
        String croak = "croak";

        for (char c : croakOfFrogs.toCharArray()) {
            int index = croak.indexOf(c);
            if (index == -1) return -1;
            count[index]++;
            if (index > 0 && count[index] > count[index - 1]) return -1;
            if (index == 0) frogs++;
            if (index == 4) frogs--;
            maxFrogs = Math.max(maxFrogs, frogs);
        }

        return count[0] == count[1] && count[1] == count[2] && count[2] == count[3] && count[3] == count[4] ? maxFrogs : -1;
    }
}