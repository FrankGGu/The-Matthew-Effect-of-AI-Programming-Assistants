import java.util.Arrays;

class Solution {

    class TrieNode {
        TrieNode[] children = new TrieNode[26];
        int bestLen = 0; // Length of the best word that has the reversed prefix leading to this node
        int bestIdx = -1; // Original index of that best word in the 'words' array
    }

    TrieNode root;

    public int[] longestCommonSuffixQueries(String[] words, String[][] queries) {
        root = new TrieNode();

        for (int i = 0; i < words.length; i++) {
            String originalWord = words[i];
            String reversedWord = new StringBuilder(originalWord).reverse().toString();
            insert(reversedWord, i, originalWord.length());
        }

        int[] ans = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            String originalQueryString = queries[i][0];
            String reversedQueryString = new StringBuilder(originalQueryString).reverse().toString();
            int queryOriginalIndexInInput = Integer.parseInt(queries[i][1]);

            ans[queryOriginalIndexInInput] = query(reversedQueryString);
        }

        return ans;
    }

    void insert(String reversedWord, int originalIdx, int originalLen) {
        TrieNode curr = root;
        for (char ch : reversedWord.toCharArray()) {
            int index = ch - 'a';
            if (curr.children[index] == null) {
                curr.children[index] = new TrieNode();
            }
            curr = curr.children[index];

            if (originalLen > curr.bestLen) {
                curr.bestLen = originalLen;
                curr.bestIdx = originalIdx;
            } else if (originalLen == curr.bestLen && originalIdx < curr.bestIdx) {
                curr.bestIdx = originalIdx;
            }
        }
    }

    int query(String reversedQueryString) {
        int currentBestIdx = -1;
        int currentBestLen = 0;

        TrieNode curr = root;
        for (char ch : reversedQueryString.toCharArray()) {
            int index = ch - 'a';
            if (curr.children[index] == null) {
                break;
            }
            curr = curr.children[index];

            if (curr.bestLen > currentBestLen) {
                currentBestLen = curr.bestLen;
                currentBestIdx = curr.bestIdx;
            } else if (curr.bestLen == currentBestLen && curr.bestIdx < currentBestIdx) {
                currentBestIdx = curr.bestIdx;
            }
        }
        return currentBestIdx;
    }
}