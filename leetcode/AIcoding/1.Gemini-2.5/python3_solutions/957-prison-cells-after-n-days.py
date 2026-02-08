class Solution:
    def prisonAfterNDays(self, cells: list[int], n: int) -> list[int]:

        def get_next_day_state(current_cells):
            new_cells = [0] * 8
            # Cells[0] and Cells[7] always become 0
            for i in range(1, 7):
                if current_cells[i-1] == current_cells[i+1]:
                    new_cells[i] = 1
                else:
                    new_cells[i] = 0
            return new_cells

        seen_states = {}
        states_sequence = []

        current_cells = cells

        for day in range(n):
            current_tuple = tuple(current_cells)

            if current_tuple in seen_states:
                prev_day = seen_states[current_tuple]
                cycle_length = day - prev_day

                remaining_days_to_simulate = n - day
                offset_in_cycle = remaining_days_to_simulate % cycle_length

                return states_sequence[prev_day + offset_in_cycle]

            seen_states[current_tuple] = day
            states_sequence.append(current_cells)

            current_cells = get_next_day_state(current_cells)

        return current_cells