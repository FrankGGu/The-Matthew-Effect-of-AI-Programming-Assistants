#include <stdlib.h>

int minSwapsCouples(int* row, int rowSize) {
    int swaps = 0;
    int* pos = (int*)malloc(sizeof(int) * rowSize);

    for (int i = 0; i < rowSize; i++) {
        pos[row[i]] = i;
    }

    for (int i = 0; i < rowSize; i += 2) {
        int person1 = row[i];
        int person_at_i_plus_1 = row[i+1];
        int partner_of_person1 = person1 ^ 1;

        if (person_at_i_plus_1 != partner_of_person1) {
            swaps++;
            int current_pos_of_partner = pos[partner_of_person1];
            int person_to_move_out_of_i_plus_1 = row[i+1];

            row[i+1] = partner_of_person1;
            row[current_pos_of_partner] = person_to_move_out_of_i_plus_1;

            pos[partner_of_person1] = i + 1;
            pos[person_to_move_out_of_i_plus_1] = current_pos_of_partner;
        }
    }

    free(pos);
    return swaps;
}