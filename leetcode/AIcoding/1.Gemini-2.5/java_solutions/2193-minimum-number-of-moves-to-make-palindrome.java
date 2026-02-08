class Solution {
    public int minMovesToMakePalindrome(String s) {
        char[] arr = s.toCharArray();
        int n = arr.length;
        int left = 0;
        int right = n - 1;
        int moves = 0;

        while (left < right) {
            if (arr[left] == arr[right]) {
                left++;
                right--;
            } else {
                int k_match_idx = -1;
                for (int i = right; i > left; i--) {
                    if (arr[i] == arr[left]) {
                        k_match_idx = i;
                        break;
                    }
                }

                int j_match_idx = -1;
                for (int i = left; i < right; i++) {
                    if (arr[i] == arr[right]) {
                        j_match_idx = i;
                        break;
                    }
                }

                if (k_match_idx == -1) { 
                    // arr[left] is the unique odd-frequency character, it has no match on the right.
                    // We must pair arr[right] with its match arr[j_match_idx].
                    moves += (j_match_idx - left);
                    char charToMove = arr[j_match_idx];
                    for (int i = j_match_idx; i > left; i--) {
                        arr[i] = arr[i - 1];
                    }
                    arr[left] = charToMove;
                    left++;
                    right--;
                } else if (j_match_idx == -1) {
                    // arr[right] is the unique odd-frequency character, it has no match on the left.
                    // We must pair arr[left] with its match arr[k_match_idx].
                    moves += (right - k_match_idx);
                    char charToMove = arr[k_match_idx];
                    for (int i = k_match_idx; i < right; i++) {
                        arr[i] = arr[i + 1];
                    }
                    arr[right] = charToMove;
                    left++;
                    right--;
                } else { 
                    // Both arr[left] and arr[right] have matches, choose the cheaper option.
                    int cost1 = right - k_match_idx; // Cost to move arr[k_match_idx] to arr[right]
                    int cost2 = j_match_idx - left;   // Cost to move arr[j_match_idx] to arr[left]

                    if (cost1 < cost2) {
                        moves += cost1;
                        char charToMove = arr[k_match_idx];
                        for (int i = k_match_idx; i < right; i++) {
                            arr[i] = arr[i + 1];
                        }
                        arr[right] = charToMove;
                        left++;
                        right--;
                    } else { // cost2 <= cost1
                        moves += cost2;
                        char charToMove = arr[j_match_idx];
                        for (int i = j_match_idx; i > left; i--) {
                            arr[i] = arr[i - 1];
                        }
                        arr[left] = charToMove;
                        left++;
                        right--;
                    }
                }
            }
        }
        return moves;
    }
}