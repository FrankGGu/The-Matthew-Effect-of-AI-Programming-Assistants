import java.util.Arrays;

class Solution {
    public long minimumCost(int m, int n, int[] horizontalCut, int[] verticalCut) {
        Arrays.sort(horizontalCut);
        Arrays.sort(verticalCut);

        long totalCost = 0;
        long horizontalPieces = 1; // Represents the number of pieces horizontally separated
        long verticalPieces = 1;   // Represents the number of pieces vertically separated

        int hPtr = horizontalCut.length - 1; // Pointer to the largest horizontal cut cost
        int vPtr = verticalCut.length - 1;   // Pointer to the largest vertical cut cost

        while (hPtr >= 0 || vPtr >= 0) {
            // Prioritize the cut with the larger cost.
            // If horizontal cuts are available AND (no vertical cuts are available OR current horizontal cut is greater than or equal to current vertical cut)
            if (hPtr >= 0 && (vPtr < 0 || horizontalCut[hPtr] >= verticalCut[vPtr])) {
                totalCost += (long)horizontalCut[hPtr] * verticalPieces;
                horizontalPieces++;
                hPtr--;
            } 
            // Else (Vertical cuts are available, and either no horizontal cuts are left OR current vertical cut is greater than current horizontal cut)
            else { // vPtr >= 0 must be true here
                totalCost += (long)verticalCut[vPtr] * horizontalPieces;
                verticalPieces++;
                vPtr--;
            }
        }

        return totalCost;
    }
}