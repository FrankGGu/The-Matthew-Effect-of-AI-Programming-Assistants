public class Solution extends SolBase {
    public int rand10() {
        int row, col, idx;
        do {
            row = rand7();
            col = rand7();
            idx = (row - 1) * 7 + col;
        } while (idx > 40);
        return (idx - 1) % 10 + 1;
    }
}