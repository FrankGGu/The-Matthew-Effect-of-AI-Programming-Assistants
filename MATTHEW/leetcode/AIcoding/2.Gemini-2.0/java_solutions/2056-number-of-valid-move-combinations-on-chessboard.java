class Solution {
    private int n;
    private int[] pieces;
    private int[] moves;
    private int ans;

    public int countCombinations(String[] pieces, int[] moves) {
        this.n = pieces.length;
        this.pieces = new int[n];
        this.moves = moves;
        this.ans = 0;

        for (int i = 0; i < n; i++) {
            if (pieces[i].equals("rook")) {
                this.pieces[i] = 0;
            } else if (pieces[i].equals("bishop")) {
                this.pieces[i] = 1;
            } else {
                this.pieces[i] = 2;
            }
        }

        int[][] positions = new int[n][2];
        solve(0, positions);

        return ans;
    }

    private void solve(int index, int[][] positions) {
        if (index == n) {
            if (isValid(positions)) {
                ans++;
            }
            return;
        }

        for (int i = 1; i <= 8; i++) {
            for (int j = 1; j <= 8; j++) {
                positions[index][0] = i;
                positions[index][1] = j;
                solve(index + 1, positions);
            }
        }
    }

    private boolean isValid(int[][] positions) {
        int maxTurns = 0;
        for (int i = 0; i < n; i++) {
            int turns = moves[i];
            int x = positions[i][0];
            int y = positions[i][1];

            for (int turn = 1; turn <= turns; turn++) {
                boolean moved = false;
                if (pieces[i] == 0) { 
                    for (int d = 0; d < 4; d++) {
                        int newX = x, newY = y;
                        if (d == 0) newX++;
                        else if (d == 1) newX--;
                        else if (d == 2) newY++;
                        else newY--;

                        if (newX >= 1 && newX <= 8 && newY >= 1 && newY <= 8) {
                            boolean collision = false;
                            for (int k = 0; k < n; k++) {
                                if (k != i && positions[k][0] == newX && positions[k][1] == newY) {
                                    collision = true;
                                    break;
                                }
                            }
                            if (!collision) {
                                x = newX;
                                y = newY;
                                moved = true;
                                break;
                            }
                        }
                    }
                } else if (pieces[i] == 1) { 
                    for (int d = 0; d < 4; d++) {
                        int newX = x, newY = y;
                        if (d == 0) { newX++; newY++; }
                        else if (d == 1) { newX++; newY--; }
                        else if (d == 2) { newX--; newY++; }
                        else { newX--; newY--; }

                        if (newX >= 1 && newX <= 8 && newY >= 1 && newY <= 8) {
                            boolean collision = false;
                            for (int k = 0; k < n; k++) {
                                if (k != i && positions[k][0] == newX && positions[k][1] == newY) {
                                    collision = true;
                                    break;
                                }
                            }
                            if (!collision) {
                                x = newX;
                                y = newY;
                                moved = true;
                                break;
                            }
                        }
                    }
                } else { 
                    if (turn == 1) {
                         for (int k = 0; k < n; k++) {
                                if (k != i && positions[k][0] == x && positions[k][1] == y) {
                                    return false;
                                }
                            }
                    }
                    moved = true;
                }

                if (!moved) {
                   x = positions[i][0];
                   y = positions[i][1];
                   break;
                }
            }
            positions[i][0] = x;
            positions[i][1] = y;
            maxTurns = Math.max(maxTurns, moves[i]);
        }

        for(int i = 0; i < n; i++){
            for(int j = i + 1; j < n; j++){
                if(positions[i][0] == positions[j][0] && positions[i][1] == positions[j][1]){
                    return false;
                }
            }
        }
        return true;
    }
}