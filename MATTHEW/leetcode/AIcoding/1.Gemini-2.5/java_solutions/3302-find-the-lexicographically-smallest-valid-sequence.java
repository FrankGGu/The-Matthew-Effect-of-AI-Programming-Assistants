import java.util.ArrayList;
import java.util.List;

class Solution {
    private char[] resultCharArr;
    private boolean[] visited;
    private boolean nPlaced;
    private int N;

    public List<Integer> findLexSmallestValidSequence(int n) {
        N = n;
        int len = 2 * n - 1;
        resultCharArr = new char[len];
        visited = new boolean[n + 1];
        nPlaced = false;

        solve(0);

        List<Integer> resultList = new ArrayList<>();
        for (char c : resultCharArr) {
            resultList.add(c - '0');
        }
        return resultList;
    }

    private boolean solve(int index) {
        if (index == 2 * N - 1) {
            return true;
        }

        if (resultCharArr[index] != 0) {
            return solve(index + 1);
        }

        for (int num = 1; num <= N; num++) {
            if (num == N) {
                if (!nPlaced) {
                    resultCharArr[index] = (char) ('0' + N);
                    nPlaced = true;

                    if (solve(index + 1)) {
                        return true;
                    }

                    nPlaced = false;
                    resultCharArr[index] = 0;
                }
            } else {
                if (!visited[num]) {
                    int pos2 = index + num + 1;

                    if (pos2 < 2 * N - 1 && resultCharArr[pos2] == 0) {
                        resultCharArr[index] = (char) ('0' + num);
                        resultCharArr[pos2] = (char) ('0' + num);
                        visited[num] = true;

                        if (solve(index + 1)) {
                            return true;
                        }

                        visited[num] = false;
                        resultCharArr[index] = 0;
                        resultCharArr[pos2] = 0;
                    }
                }
            }
        }
        return false;
    }
}