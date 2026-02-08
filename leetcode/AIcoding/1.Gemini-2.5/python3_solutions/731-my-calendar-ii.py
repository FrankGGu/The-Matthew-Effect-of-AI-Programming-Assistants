class MyCalendarTwo:

    def __init__(self):
        self.calendar = [] # Stores all booked intervals [start, end)
        self.overlaps = [] # Stores intervals that are double-booked [start, end), disjoint and sorted

    # Helper to merge a list of intervals into a single list of disjoint, sorted intervals.
    # This is the standard "Merge Intervals" problem.
    def _merge_intervals(self, intervals):
        if not intervals:
            return []

        # Sort intervals by their start times
        intervals.sort() 

        merged = []
        for current_start, current_end in intervals:
            # If the merged list is empty or the current interval does not overlap with the last merged interval
            # (current_start is greater than or equal to the end of the last merged interval)
            if not merged or merged[-1][1] <= current_start: 
                merged.append([current_start, current_end])
            else:
                # There is an overlap, merge the current interval with the last one
                merged[-1][1] = max(merged[-1][1], current_end)
        return merged

    def book(self, start: int, end: int) -> bool:
        # Step 1: Check for triple booking
        # Iterate through the list of already double-booked (overlap) intervals.
        # If the new event [start, end) overlaps with any interval in self.overlaps,
        # it means this segment would become triple-booked.
        for ov_start, ov_end in self.overlaps:
            # Check for overlap: max(start, ov_start) < min(end, ov_end)
            if max(start, ov_start) < min(end, ov_end):
                return False # Triple booking detected

        # Step 2: If no triple booking, the event can be booked.
        # Now, identify new segments that will become double-booked due to this new event.
        # These are the intersections of the new event with existing events in self.calendar.
        new_overlaps_to_add = []
        for cal_start, cal_end in self.calendar:
            intersect_start = max(start, cal_start)
            intersect_end = min(end, cal_end)
            # If there's an actual overlap (intersection is not empty)
            if intersect_start < intersect_end:
                new_overlaps_to_add.append([intersect_start, intersect_end])

        # Step 3: Add the new event to the main calendar.
        self.calendar.append([start, end])

        # Step 4: Update the self.overlaps list.
        # We need to add the new_overlaps_to_add to self.overlaps,
        # ensuring self.overlaps remains a list of disjoint and sorted intervals.

        # First, merge the newly found overlaps into a disjoint list.
        # This is needed because new_overlaps_to_add might contain overlapping intervals itself.
        merged_new_overlaps = self._merge_intervals(new_overlaps_to_add)

        # Now, combine the existing self.overlaps with the merged_new_overlaps.
        # Both are already sorted and disjoint.
        # The simplest way to merge them and keep the resulting list sorted and disjoint
        # is to concatenate them and then apply the _merge_intervals function again.
        all_overlaps_combined = self.overlaps + merged_new_overlaps
        self.overlaps = self._merge_intervals(all_overlaps_combined)

        return True