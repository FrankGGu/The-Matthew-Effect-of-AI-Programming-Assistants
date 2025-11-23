public class Solution {
    public boolean sumGame(String a, String b) {
        int sumA = 0, sumB = 0;
        for (char c : a.toCharArray()) {
            if (c == 'x') continue;
            sumA += c - '0';
        }
        for (char c : b.toCharArray()) {
            if (c == 'x') continue;
            sumB += c - '0';
        }
        int countA = 0, countB = 0;
        for (char c : a.toCharArray()) {
            if (c == 'x') countA++;
        }
        for (char c : b.toCharArray()) {
            if (c == 'x') countB++;
        }
        int totalMoves = countA + countB;
        int diff = sumA - sumB;
        return (diff % 2 != 0) || (totalMoves % 2 != 0);
    }
}