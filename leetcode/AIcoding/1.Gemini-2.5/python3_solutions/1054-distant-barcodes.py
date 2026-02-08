import collections

class Solution:
    def rearrangeBarcodes(self, barcodes: list[int]) -> list[int]:
        counts = collections.Counter(barcodes)

        # Create a list of (barcode, count) tuples, sorted by count in descending order
        # For example: [(1, 3), (2, 2), (3, 1)] for input [1,1,1,2,2,3]
        sorted_items = sorted(counts.items(), key=lambda item: item[1], reverse=True)

        # Flatten the sorted items into a single list based on their counts
        # Example: [1, 1, 1, 2, 2, 3]
        flat_sorted_barcodes = []
        for barcode, count in sorted_items:
            flat_sorted_barcodes.extend([barcode] * count)

        n = len(barcodes)
        result = [0] * n

        # Fill even positions first
        # This ensures maximum separation for the most frequent elements
        idx = 0
        for i in range(0, n, 2):
            result[i] = flat_sorted_barcodes[idx]
            idx += 1

        # Then fill odd positions
        for i in range(1, n, 2):
            result[i] = flat_sorted_barcodes[idx]
            idx += 1

        return result