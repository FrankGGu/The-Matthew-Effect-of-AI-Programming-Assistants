import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> beautifulArray(int N) {
        List<Integer> result = new ArrayList<>();
        generateBeautifulArray(N, result);
        return result;
    }

    private void generateBeautifulArray(int N, List<Integer> result) {
        if (N == 1) {
            result.add(1);
            return;
        }
        List<Integer> odd = new ArrayList<>();
        List<Integer> even = new ArrayList<>();
        for (int num : result) {
            if (num % 2 == 1) {
                odd.add(num);
            } else {
                even.add(num);
            }
        }
        for (int i = 1; i <= N; i += 2) {
            result.add(i);
        }
        generateBeautifulArray(N / 2, odd);
        generateBeautifulArray((N + 1) / 2, even);
        result.addAll(odd);
        result.addAll(even);
    }
}