class Solution {
    public String oddString(String[] words) {
        int n = words.length;
        int len = words[0].length();
        int[] diff0 = new int[len - 1];
        int[] diff1 = new int[len - 1];
        int[] diff2 = new int[len - 1];

        for (int i = 0; i < len - 1; i++) {
            diff0[i] = words[0].charAt(i + 1) - words[0].charAt(i);
            diff1[i] = words[1].charAt(i + 1) - words[1].charAt(i);
            if (n > 2) {
                diff2[i] = words[2].charAt(i + 1) - words[2].charAt(i);
            }
        }

        if (n == 2) {
            boolean same = true;
            for (int i = 0; i < len - 1; i++) {
                if (diff0[i] != diff1[i]) {
                    same = false;
                    break;
                }
            }
            if (same) return "";
            else {
                int[] diffOther = new int[len - 1];
                for(int i = 3; i < n; i++){
                    for (int j = 0; j < len - 1; j++) {
                        diffOther[j] = words[i].charAt(j + 1) - words[i].charAt(j);
                    }
                    boolean same0 = true;
                    boolean same1 = true;

                    for(int j = 0; j < len - 1; j++){
                        if(diff0[j] != diffOther[j]) same0 = false;
                        if(diff1[j] != diffOther[j]) same1 = false;
                    }

                    if(!same0) return words[0];
                    if(!same1) return words[1];
                }
                return words[0];
            }
        } else {
            boolean same01 = true;
            boolean same02 = true;
            boolean same12 = true;

            for (int i = 0; i < len - 1; i++) {
                if (diff0[i] != diff1[i]) same01 = false;
                if (diff0[i] != diff2[i]) same02 = false;
                if (diff1[i] != diff2[i]) same12 = false;
            }

            if (same01 && same02) return words[n - 1];

            if (same01) return words[2];
            if (same02) return words[1];
            if (same12) return words[0];

            return "";
        }
    }
}