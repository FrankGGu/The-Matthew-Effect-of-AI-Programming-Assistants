import java.util.Arrays;

public class Solution {
    public boolean gcdSort(int[] nums) {
        int max = Arrays.stream(nums).max().getAsInt();
        int[] gcdArray = new int[max + 1];
        for (int num : nums) {
            gcdArray[num]++;
        }

        for (int i = 1; i <= max; i++) {
            if (gcdArray[i] > 0) {
                for (int j = i; j <= max; j += i) {
                    if (gcdArray[j] > 0) {
                        gcdArray[j] += gcdArray[i];
                        gcdArray[i] = 0;
                    }
                }
            }
        }

        Integer[] sorted = Arrays.stream(nums).boxed().toArray(Integer[]::new);
        Arrays.sort(sorted);

        for (int i = 0; i < nums.length; i++) {
            if (gcdArray[nums[i]] == 0) {
                return false;
            }
            gcdArray[nums[i]]--;
        }

        return true;
    }
}