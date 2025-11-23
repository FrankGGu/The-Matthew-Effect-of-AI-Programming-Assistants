class Solution:
    def mostBooked(self, n: int, meetings: list[list[int]]) -> int:
        meetings.sort()

        room_free_time = [0] * n
        meeting_counts = [0] * n

        for start, end in meetings:
            duration = end - start

            chosen_room_idx = -1

            # 1. Try to find an immediately available room (room_free_time[i] <= start)
            #    Prioritize the smallest index room.
            for i in range(n):
                if room_free_time[i] <= start:
                    chosen_room_idx = i
                    break # Found the smallest indexed available room

            if chosen_room_idx != -1:
                # An immediately available room was found
                room_free_time[chosen_room_idx] = end # Meeting ends at 'end' time
                meeting_counts[chosen_room_idx] += 1
            else:
                # 2. No room was immediately available. Find the room that frees up earliest.
                #    If ties in free time, pick the smallest index.
                earliest_free_time = float('inf')
                earliest_free_room_idx = -1

                for i in range(n):
                    if room_free_time[i] < earliest_free_time:
                        earliest_free_time = room_free_time[i]
                        earliest_free_room_idx = i
                    elif room_free_time[i] == earliest_free_time:
                        # Tie in earliest free time, pick smallest index
                        earliest_free_room_idx = min(earliest_free_room_idx, i)

                chosen_room_idx = earliest_free_room_idx

                # The meeting's actual start time is delayed to earliest_free_time
                # Its end time will be earliest_free_time + duration
                room_free_time[chosen_room_idx] = earliest_free_time + duration
                meeting_counts[chosen_room_idx] += 1

        # Find the room with the maximum number of meetings
        max_meetings = -1
        result_room = -1
        for i in range(n):
            if meeting_counts[i] > max_meetings:
                max_meetings = meeting_counts[i]
                result_room = i

        return result_room