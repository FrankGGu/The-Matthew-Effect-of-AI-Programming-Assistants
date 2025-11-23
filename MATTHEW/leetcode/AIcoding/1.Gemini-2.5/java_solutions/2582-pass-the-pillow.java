class Solution {
    public int passThePillow(int n, int time) {
        if (n == 1) {
            return 1;
        }

        int stepsInOneDirection = n - 1;
        int numFullPasses = time / stepsInOneDirection;
        int remainingSteps = time % stepsInOneDirection;

        if (numFullPasses % 2 == 0) {
            // Even number of full passes means the pillow is currently moving from person 1 towards person n.
            // The position is 1 + the remaining steps.
            return 1 + remainingSteps;
        } else {
            // Odd number of full passes means the pillow is currently moving from person n towards person 1.
            // The position is n - the remaining steps.
            return n - remainingSteps;
        }
    }
}