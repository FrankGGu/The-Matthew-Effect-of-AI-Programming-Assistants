class Solution {
    public String gobang(int[][] pieces) {
        int[][] directions = {{0, 1}, {1, 0}, {1, 1}, {1, -1}};
        Set<String> black = new HashSet<>();
        Set<String> white = new HashSet<>();

        for (int[] piece : pieces) {
            String key = piece[0] + "," + piece[1];
            if (piece[2] == 0) {
                black.add(key);
            } else {
                white.add(key);
            }
        }

        for (String pos : black) {
            String[] parts = pos.split(",");
            int x = Integer.parseInt(parts[0]);
            int y = Integer.parseInt(parts[1]);

            for (int[] dir : directions) {
                int dx = dir[0], dy = dir[1];
                int count = 1;
                int left = 0, right = 0;
                boolean leftBlocked = false, rightBlocked = false;

                for (int i = 1; i <= 5; i++) {
                    int nx = x + i * dx;
                    int ny = y + i * dy;
                    String nPos = nx + "," + ny;
                    if (!black.contains(nPos)) {
                        if (white.contains(nPos)) {
                            rightBlocked = true;
                        }
                        break;
                    }
                    count++;
                    right++;
                }

                for (int i = 1; i <= 5; i++) {
                    int nx = x - i * dx;
                    int ny = y - i * dy;
                    String nPos = nx + "," + ny;
                    if (!black.contains(nPos)) {
                        if (white.contains(nPos)) {
                            leftBlocked = true;
                        }
                        break;
                    }
                    count++;
                    left++;
                }

                if (count >= 5) {
                    return "Black";
                }

                if (count == 4 && !leftBlocked && !rightBlocked) {
                    return "Black";
                }
            }
        }

        Set<String> candidates = new HashSet<>();
        for (String pos : white) {
            String[] parts = pos.split(",");
            int x = Integer.parseInt(parts[0]);
            int y = Integer.parseInt(parts[1]);

            for (int[] dir : directions) {
                int dx = dir[0], dy = dir[1];
                int count = 1;
                int left = 0, right = 0;
                boolean leftBlocked = false, rightBlocked = false;

                for (int i = 1; i <= 5; i++) {
                    int nx = x + i * dx;
                    int ny = y + i * dy;
                    String nPos = nx + "," + ny;
                    if (!white.contains(nPos)) {
                        if (black.contains(nPos)) {
                            rightBlocked = true;
                        }
                        break;
                    }
                    count++;
                    right++;
                }

                for (int i = 1; i <= 5; i++) {
                    int nx = x - i * dx;
                    int ny = y - i * dy;
                    String nPos = nx + "," + ny;
                    if (!white.contains(nPos)) {
                        if (black.contains(nPos)) {
                            leftBlocked = true;
                        }
                        break;
                    }
                    count++;
                    left++;
                }

                if (count >= 5) {
                    return "White";
                }

                if (count == 4 && !leftBlocked && !rightBlocked) {
                    for (int i = -left; i <= right; i++) {
                        int nx = x + i * dx;
                        int ny = y + i * dy;
                        String nPos = nx + "," + ny;
                        if (!black.contains(nPos) && !white.contains(nPos)) {
                            candidates.add(nPos);
                        }
                    }
                }
            }
        }

        for (String pos : candidates) {
            String[] parts = pos.split(",");
            int x = Integer.parseInt(parts[0]);
            int y = Integer.parseInt(parts[1]);
            black.add(pos);

            for (int[] dir : directions) {
                int dx = dir[0], dy = dir[1];
                int count = 1;

                for (int i = 1; i <= 5; i++) {
                    int nx = x + i * dx;
                    int ny = y + i * dy;
                    if (!black.contains(nx + "," + ny)) break;
                    count++;
                }

                for (int i = 1; i <= 5; i++) {
                    int nx = x - i * dx;
                    int ny = y - i * dy;
                    if (!black.contains(nx + "," + ny)) break;
                    count++;
                }

                if (count >= 5) {
                    return "Black";
                }
            }

            black.remove(pos);
        }

        return "None";
    }
}