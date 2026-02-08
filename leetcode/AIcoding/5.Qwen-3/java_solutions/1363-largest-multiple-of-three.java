public class Solution {

import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

public class Solution {
    public String largestMultipleOfThree(int[] digits) {
        Arrays.sort(digits);
        List<Integer> list = new ArrayList<>();
        int sum = 0;
        for (int d : digits) {
            sum += d;
            list.add(d);
        }
        if (sum % 3 == 0) {
            if (list.get(list.size() - 1) == 0) {
                return "0";
            }
            StringBuilder sb = new StringBuilder();
            for (int i = list.size() - 1; i >= 0; i--) {
                sb.append(list.get(i));
            }
            return sb.toString();
        } else if (sum % 3 == 1) {
            boolean found = false;
            for (int i = list.size() - 1; i >= 0; i--) {
                if (list.get(i) % 3 == 1) {
                    list.remove(i);
                    found = true;
                    break;
                }
            }
            if (!found) {
                for (int i = list.size() - 1; i >= 0; i--) {
                    if (list.get(i) % 3 == 2) {
                        list.remove(i);
                        for (int j = list.size() - 1; j >= 0; j--) {
                            if (list.get(j) % 3 == 2) {
                                list.remove(j);
                                found = true;
                                break;
                            }
                        }
                        break;
                    }
                }
            }
        } else {
            boolean found = false;
            for (int i = list.size() - 1; i >= 0; i--) {
                if (list.get(i) % 3 == 2) {
                    list.remove(i);
                    found = true;
                    break;
                }
            }
            if (!found) {
                for (int i = list.size() - 1; i >= 0; i--) {
                    if (list.get(i) % 3 == 1) {
                        list.remove(i);
                        for (int j = list.size() - 1; j >= 0; j--) {
                            if (list.get(j) % 3 == 1) {
                                list.remove(j);
                                found = true;
                                break;
                            }
                        }
                        break;
                    }
                }
            }
        }
        if (list.isEmpty()) {
            return "0";
        }
        while (list.size() > 1 && list.get(list.size() - 1) == 0) {
            list.remove(list.size() - 1);
        }
        StringBuilder sb = new StringBuilder();
        for (int i = list.size() - 1; i >= 0; i--) {
            sb.append(list.get(i));
        }
        return sb.toString();
    }
}
}