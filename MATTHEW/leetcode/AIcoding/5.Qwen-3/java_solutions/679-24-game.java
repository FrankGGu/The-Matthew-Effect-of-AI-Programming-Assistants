public class Solution {

import java.util.*;

public class Solution {
    public boolean judgePoint24(int[] nums) {
        List<Double> list = new ArrayList<>();
        for (int num : nums) {
            list.add((double) num);
        }
        return backtrack(list);
    }

    private boolean backtrack(List<Double> list) {
        if (list.size() == 1) {
            return Math.abs(list.get(0) - 24) < 1e-6;
        }
        for (int i = 0; i < list.size(); i++) {
            for (int j = 0; j < list.size(); j++) {
                if (i != j) {
                    List<Double> next = new ArrayList<>();
                    for (int k = 0; k < list.size(); k++) {
                        if (k != i && k != j) {
                            next.add(list.get(k));
                        }
                    }
                    double a = list.get(i);
                    double b = list.get(j);
                    next.add(a + b);
                    if (backtrack(next)) return true;
                    next.remove(next.size() - 1);
                    next.add(a - b);
                    if (backtrack(next)) return true;
                    next.remove(next.size() - 1);
                    next.add(b - a);
                    if (backtrack(next)) return true;
                    next.remove(next.size() - 1);
                    next.add(a * b);
                    if (backtrack(next)) return true;
                    next.remove(next.size() - 1);
                    if (b != 0) {
                        next.add(a / b);
                        if (backtrack(next)) return true;
                    }
                    next.remove(next.size() - 1);
                    if (a != 0) {
                        next.add(b / a);
                        if (backtrack(next)) return true;
                    }
                    next.remove(next.size() - 1);
                }
            }
        }
        return false;
    }
}
}