class Solution {
    public int computeArea(int A, int B, int C, int D) {
        int area1 = (C - A) * (D - B);
        int area2 = (C - A) * (D - B);

        int overlapWidth = Math.max(0, Math.min(C, C) - Math.max(A, A));
        int overlapHeight = Math.max(0, Math.min(D, D) - Math.max(B, B));
        int overlapArea = overlapWidth * overlapHeight;

        return area1 + area2 - overlapArea;
    }
}