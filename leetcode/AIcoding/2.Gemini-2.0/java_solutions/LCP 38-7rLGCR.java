class Solution {
    public int guardCastle(String[] grid) {
        int m = grid.length;
        int n = grid[0].length();
        int count = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i].charAt(j) == '0') {
                    boolean left = false;
                    for (int k = j - 1; k >= 0; k--) {
                        if (grid[i].charAt(k) == '1') {
                            left = true;
                            break;
                        } else if (grid[i].charAt(k) == '2') {
                            break;
                        }
                    }

                    boolean right = false;
                    for (int k = j + 1; k < n; k++) {
                        if (grid[i].charAt(k) == '1') {
                            right = true;
                            break;
                        } else if (grid[i].charAt(k) == '2') {
                            break;
                        }
                    }

                    boolean up = false;
                    for (int k = i - 1; k >= 0; k--) {
                        if (grid[k].charAt(j) == '1') {
                            up = true;
                            break;
                        } else if (grid[k].charAt(j) == '2') {
                            break;
                        }
                    }

                    boolean down = false;
                    for (int k = i + 1; k < m; k++) {
                        if (grid[k].charAt(j) == '1') {
                            down = true;
                            break;
                        } else if (grid[k].charAt(j) == '2') {
                            break;
                        }
                    }

                    if (left && right && up && down) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
}