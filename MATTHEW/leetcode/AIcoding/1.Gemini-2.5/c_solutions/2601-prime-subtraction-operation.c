#include <stdbool.h>

#define MAX_NUM_VAL 1000

static bool is_sieve_initialized = false;
static bool is_prime_sieve[MAX_NUM_VAL + 1];
static int primes_list[200]; 
static int primes_count = 0;

void initialize_sieve_and_primes() {
    if (is_sieve_initialized) {
        return;
    }

    for (int i = 0; i <= MAX_NUM_VAL; ++i) {
        is_prime_sieve[i] = true;
    }
    is_prime_sieve[0] = false;
    is_prime_sieve[1] = false;

    for (int p = 2; p <= MAX_NUM_VAL; ++p) {
        if (is_prime_sieve[p]) {
            primes_list[primes_count++] = p;
            for (int i = p * p; i <= MAX_NUM_VAL; i += p) {
                is_prime_sieve[i] = false;
            }
        }
    }
    is_sieve_initialized = true;
}

int find_largest_prime_le(int X) {
    if (X < 2) {
        return 0;
    }

    int low = 0;
    int high = primes_count - 1;
    int result_prime = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (primes_list[mid] <= X) {
            result_prime = primes_list[mid];
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return result_prime;
}

bool primeSubOperation(int* nums, int numsSize) {
    initialize_sieve_and_primes();

    int current_prev_val = 0;

    for (int i = 0; i < numsSize; ++i) {
        int original_num = nums[i];

        int upper_bound_for_p = original_num - current_prev_val - 1;

        int p_to_subtract = find_largest_prime_le(upper_bound_for_p);

        if (p_to_subtract > 0) {
            current_prev_val = original_num - p_to_subtract;
        } else {
            if (original_num <= current_prev_val) {
                return false;
            }
            current_prev_val = original_num;
        }
    }

    return true;
}