class Solution {
    public int minSwapsCouples(int[] row) {
        int n = row.length;
        int[] pos = new int[n]; // pos[person_id] = index_in_row

        for (int i = 0; i < n; i++) {
            pos[row[i]] = i;
        }

        int swaps = 0;
        for (int i = 0; i < n; i += 2) {
            int p1 = row[i];
            int p2 = row[i + 1];

            // Determine the partner needed for p1
            int partnerOfP1 = p1 % 2 == 0 ? p1 + 1 : p1 - 1;
            // Or more simply: int partnerOfP1 = p1 ^ 1;

            if (p2 != partnerOfP1) {
                // p2 is not the partner of p1. We need to find partnerOfP1 and swap it into row[i+1].

                // Find the current position of partnerOfP1
                int idxPartner = pos[partnerOfP1];

                // Get the person currently at row[i+1]
                int personAtIPlus1 = row[i + 1];

                // Perform the swap in the 'row' array
                row[i + 1] = partnerOfP1;
                row[idxPartner] = personAtIPlus1;

                // Update the 'pos' array to reflect the swap
                pos[partnerOfP1] = i + 1;
                pos[personAtIPlus1] = idxPartner;

                swaps++;
            }
        }

        return swaps;
    }
}