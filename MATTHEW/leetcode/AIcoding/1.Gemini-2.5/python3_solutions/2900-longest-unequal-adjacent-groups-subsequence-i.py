class Solution:
    def getLongestSubsequence(self, groupSizes: list[int], words: list[str]) -> list[str]:
        result_words = []
        # To keep track of the group size of the last word added to result_words.
        # Initialize with an invalid group size (group sizes are 1 to 10^5)
        # to ensure the first element is always added.
        last_added_group_size = -1 

        for i in range(len(groupSizes)):
            current_group_size = groupSizes[i]
            current_word = words[i]

            if not result_words or current_group_size != last_added_group_size:
                # If result_words is empty, or the current group size is different from the last one,
                # we must append this word to maximize the length of the subsequence.
                result_words.append(current_word)
                last_added_group_size = current_group_size
            else: # current_group_size == last_added_group_size
                # If the current group size is the same as the last one in our subsequence,
                # we cannot extend the length of the subsequence by adding this word.
                # However, we can potentially make the subsequence lexicographically smaller
                # by replacing the last word in 'result_words' if the current word is smaller.
                if current_word < result_words[-1]:
                    result_words[-1] = current_word

        return result_words