class Solution {
    public boolean judgePoint24(int[] nums) {
        List<Double> list = new ArrayList<>();
        for (int num : nums) {
            list.add((double) num);
        }
        return dfs(list);
    }

    private boolean dfs(List<Double> list) {
        if (list.size() == 1) {
            return Math.abs(list.get(0) - 24) < 1e-6;
        }

        for (int i = 0; i < list.size(); i++) {
            for (int j = 0; j < list.size(); j++) {
                if (i == j) continue;
                List<Double> next = new ArrayList<>();
                for (int k = 0; k < list.size(); k++) {
                    if (k != i && k != j) {
                        next.add(list.get(k));
                    }
                }

                for (int op = 0; op < 4; op++) {
                    if (op < 2 && i > j) continue;
                    double a = list.get(i);
                    double b = list.get(j);
                    double res = 0;
                    if (op == 0) {
                        res = a + b;
                    } else if (op == 1) {
                        res = a * b;
                    } else if (op == 2) {
                        res = a - b;
                    } else if (op == 3) {
                        if (b == 0) continue;
                        res = a / b;
                    }
                    next.add(res);
                    if (dfs(next)) {
                        return true;
                    }
                    next.remove(next.size() - 1);
                }
            }
        }
        return false;
    }
}