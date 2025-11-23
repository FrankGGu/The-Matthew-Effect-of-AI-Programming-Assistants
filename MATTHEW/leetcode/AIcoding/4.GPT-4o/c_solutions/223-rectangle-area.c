int computeArea(int A, int B, int C, int D, int E, int F, int G, int H) {
    int area1 = (C - A) * (D - B);
    int area2 = (G - E) * (H - F);

    int overlapWidth = fmax(0, fmin(C, G) - fmax(A, E));
    int overlapHeight = fmax(0, fmin(D, H) - fmax(B, F));
    int overlapArea = overlapWidth * overlapHeight;

    return area1 + area2 - overlapArea;
}