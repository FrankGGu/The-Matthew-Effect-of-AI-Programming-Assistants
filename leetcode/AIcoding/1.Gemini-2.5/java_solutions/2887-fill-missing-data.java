class Solution {
    public int[] fillMissingData(int[] data) {
        if (data == null || data.length == 0) {
            return data;
        }

        int n = data.length;
        int[] leftIdx = new int[n];
        int[] rightIdx = new int[n];

        int lastNonZeroIdx = -1;
        for (int i = 0; i < n; i++) {
            if (data[i] != 0) {
                lastNonZeroIdx = i;
            }
            leftIdx[i] = lastNonZeroIdx;
        }

        int nextNonZeroIdx = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (data[i] != 0) {
                nextNonZeroIdx = i;
            }
            rightIdx[i] = nextNonZeroIdx;
        }

        for (int i = 0; i < n; i++) {
            if (data[i] == 0) {
                int l_idx = leftIdx[i];
                int r_idx = rightIdx[i];

                if (l_idx != -1 && r_idx != -1) {
                    int valL = data[l_idx];
                    int valR = data[r_idx];
                    int distL = i - l_idx;
                    int distR = r_idx - i;

                    if (distL < distR) {
                        data[i] = valL;
                    } else if (distR < distL) {
                        data[i] = valR;
                    } else {
                        data[i] = (valL + valR) / 2;
                    }
                } else if (l_idx != -1) {
                    data[i] = data[l_idx];
                } else if (r_idx != -1) {
                    data[i] = data[r_idx];
                }
            }
        }

        return data;
    }
}