import collections

class Solution:
    def countCompleteSubstrings(self, word: str, k: int) -> int:
        total_complete_substrings = 0
        n = len(word)

        # Step 1: Split the word into segments based on the k-condition
        # A complete substring cannot cross a boundary where |ord(c1) - ord(c2)| > k.
        segments = []
        current_segment_start = 0
        for i in range(1, n):
            if abs(ord(word[i]) - ord(word[i-1])) > k:
                segments.append(word[current_segment_start:i])
                current_segment_start = i
        segments.append(word[current_segment_start:]) # Add the last segment

        # Step 2: For each segment, count complete substrings
        for segment in segments:
            total_complete_substrings += self._count_complete_in_segment(segment)

        return total_complete_substrings

    def _count_complete_in_segment(self, s: str) -> int:
        n = len(s)
        count = 0

        # Iterate over possible number of unique characters 'm'
        # 'm' can range from 1 to 26 (alphabet size)
        # We only need to consider 'm' up to the length of the segment, as 'num_distinct_chars' cannot exceed 'n'.
        for m in range(1, min(27, n + 1)):
            freq = [0] * 26  # Frequency of each character (a-z) in the current window
            # freq_of_freq[f] stores the count of characters that appear 'f' times
            freq_of_freq = collections.defaultdict(int) 
            num_distinct_chars = 0 # Number of unique characters in the current window
            left = 0

            for right in range(n):
                char_idx = ord(s[right]) - ord('a')

                # Update freq_of_freq for the old frequency of s[right]
                if freq[char_idx] > 0:
                    freq_of_freq[freq[char_idx]] -= 1
                    if freq_of_freq[freq[char_idx]] == 0:
                        del freq_of_freq[freq[char_idx]]
                else:
                    # s[right] is a new distinct character in the window
                    num_distinct_chars += 1 

                # Update freq and freq_of_freq for the new frequency of s[right]
                freq[char_idx] += 1
                freq_of_freq[freq[char_idx]] += 1

                # Shrink the window from the left if num_distinct_chars exceeds 'm'
                while num_distinct_chars > m:
                    left_char_idx = ord(s[left]) - ord('a')

                    # Update freq_of_freq for the old frequency of s[left]
                    freq_of_freq[freq[left_char_idx]] -= 1
                    if freq_of_freq[freq[left_char_idx]] == 0:
                        del freq_of_freq[freq[left_char_idx]]

                    # Update freq and num_distinct_chars for s[left]
                    freq[left_char_idx] -= 1
                    if freq[left_char_idx] == 0:
                        # s[left] is no longer present in the window
                        num_distinct_chars -= 1 

                    # Update freq_of_freq for the new frequency of s[left] (if it still exists)
                    if freq[left_char_idx] > 0:
                        freq_of_freq[freq[left_char_idx]] += 1

                    left += 1

                # At this point, num_distinct_chars <= m
                # If num_distinct_chars == m, check if the substring s[left:right+1] is complete
                if num_distinct_chars == m:
                    # A substring is complete if all 'm' unique characters appear the same number of times.
                    # This means there should be only one distinct frequency value 'x' among the 'm' characters,
                    # and this frequency 'x' should be associated with exactly 'm' characters.
                    if len(freq_of_freq) == 1:
                        # Get the common frequency 'x' (the only key in freq_of_freq)
                        x = next(iter(freq_of_freq.keys())) 
                        if freq_of_freq[x] == m: # All 'm' distinct characters have frequency 'x'
                            count += 1
        return count