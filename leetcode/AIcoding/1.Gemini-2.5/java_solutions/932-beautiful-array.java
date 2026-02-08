import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    Map<Integer, List<Integer>> memo;

    public int[] beautifulArray(int N) {
        memo = new HashMap<>();
        List<Integer> resultList = generate(N);
        int[] result = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            result[i] = resultList.get(i);
        }
        return result;
    }

    private List<Integer> generate(int N) {
        if (memo.containsKey(N)) {
            return memo.get(N);
        }

        List<Integer> ans = new ArrayList<>();
        if (N == 1) {
            ans.add(1);
        } else {
            for (int x : generate((N + 1) / 2)) {
                ans.add(2 * x - 1);
            }
            for (int x : generate(N / 2)) {
                ans.add(2 * x);
            }
        }
        memo.put(N, ans);
        return ans;
    }
}