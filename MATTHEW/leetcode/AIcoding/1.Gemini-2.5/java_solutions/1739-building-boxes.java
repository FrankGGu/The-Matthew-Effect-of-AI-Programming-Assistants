class Solution {
    public long buildingBoxes(int n) {
        long N = n;

        long k = 0; // Represents the side length of the base of the largest complete pyramid
        long floorBoxesForK = 0; // Number of boxes on the floor for a complete pyramid of height k
        long totalBoxesForK = 0; // Total number of boxes for a complete pyramid of height k

        // Find the largest 'k' such that a complete pyramid of height 'k' (and base side 'k')
        // has 'totalBoxesForK' boxes, where totalBoxesForK <= N.
        // The formula for total boxes in a pyramid of height 'k' is k * (k + 1) * (k + 2) / 6.
        // The formula for floor boxes in a pyramid of height 'k' is k * (k + 1) / 2.
        while (true) {
            long nextK = k + 1;
            long nextFloorBoxes = floorBoxesForK + nextK; // This is (k+1)*(k+2)/2
            long nextTotalBoxes = totalBoxesForK + nextFloorBoxes; // This is (k+1)*(k+2)*(k+3)/6

            if (nextTotalBoxes > N) {
                break;
            }
            k = nextK;
            floorBoxesForK = nextFloorBoxes;
            totalBoxesForK = nextTotalBoxes;
        }

        // At this point:
        // 'k' is the side length of the base of the largest complete pyramid that fits within N boxes.
        // 'floorBoxesForK' is the number of floor boxes for this complete pyramid (F(k)).
        // 'totalBoxesForK' is the total number of boxes in this complete pyramid (T(k)).

        // If totalBoxesForK is exactly N, then floorBoxesForK is the answer.
        if (totalBoxesForK == N) {
            return floorBoxesForK;
        }

        // If totalBoxesForK > N, it means we overshot.
        // We actually need 'N' boxes, but we built a pyramid with 'totalBoxesForK' boxes.
        // The pyramid of height 'k' consists of a pyramid of height 'k-1' (which has T(k-1) boxes)
        // and a base layer of F(k) boxes.
        // T(k-1) = totalBoxesForK - floorBoxesForK.
        // The number of boxes we still need to place after forming a pyramid of height k-1 is:
        long remainingN = N - (totalBoxesForK - floorBoxesForK);

        // These 'remainingN' boxes must be placed on the floor to form the 'k'-th layer.
        // The number of floor boxes for the pyramid of height k-1 is F(k-1) = floorBoxesForK - k.
        // So, the total floor boxes needed is F(k-1) + remainingN.
        long ans = (floorBoxesForK - k) + remainingN;

        return ans;
    }
}