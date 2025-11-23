#include <stdlib.h>
#include <string.h>
#include <stdio.h> // For sscanf

typedef struct {
    int book_id;
    char* name;
    char* available_from; // YYYY-MM-DD (This field might be present but not used in this specific interpretation)
    int stock;
} Book;

typedef struct {
    int order_id;
    int book_id;
    int quantity;
    char* dispatch_date; // YYYY-MM-DD
} Order;

static int dateToInt(const char* dateStr) {
    int year, month, day;
    sscanf(dateStr, "%d-%d-%d", &year, &month, &day);
    return year * 10000 + month * 100 + day;
}

#define REFERENCE_DATE_INT 20190605
#define ONE_YEAR_AGO_DATE_INT 20180605

#define MAX_BOOK_ID 100001 // Array size for book_id from 1 to 100000

char** findBooks(Book* books, int booksSize, Order* orders, int ordersSize, int* returnSize) {
    // Allocate an array to store the total ordered quantity for each book_id.
    // book_id will be used as an index. All elements are initialized to 0 by calloc.
    int* orderedQuantities = (int*)calloc(MAX_BOOK_ID, sizeof(int));
    if (!orderedQuantities) {
        *returnSize = 0;
        return NULL;
    }

    // Iterate through all orders to sum quantities for books dispatched within the last year.
    for (int i = 0; i < ordersSize; i++) {
        int dispatchDateInt = dateToInt(orders[i].dispatch_date);

        // Check if the order's dispatch date falls within the specified "last year" range.
        if (dispatchDateInt >= ONE_YEAR_AGO_DATE_INT && dispatchDateInt <= REFERENCE_DATE_INT) {
            // Ensure the book_id is within the valid bounds of our `orderedQuantities` array.
            if (orders[i].book_id > 0 && orders[i].book_id < MAX_BOOK_ID) {
                orderedQuantities[orders[i].book_id] += orders[i].quantity;
            }
        }
    }

    // Prepare to collect the names of books that meet the "no available copies" criterion.
    // Allocate space for the maximum possible number of results (all books).
    char** result = (char**)malloc(booksSize * sizeof(char*));
    if (!result) {
        free(orderedQuantities);
        *returnSize = 0;
        return NULL;
    }
    int count = 0; // To track the actual number of books found.

    // Iterate through all books to check the condition.
    for (int i = 0; i < booksSize; i++) {
        int bookId = books[i].book_id;

        // Ensure the book_id is valid for lookup in `orderedQuantities`.
        if (bookId > 0 && bookId < MAX_BOOK_ID) {
            // The condition for "no available copies" is:
            // A book's stock is less than or equal to the total quantity ordered in the last year.
            if (books[i].stock <= orderedQuantities[bookId]) {
                // Duplicate the book's name string and add it to the result array.
                // `strdup` allocates new memory for the string, which must be freed later.
                result[count] = strdup(books[i].name);
                if (!result[count]) {
                    // Handle memory allocation failure for string duplication.
                    // Free all strings allocated so far and the result array itself.
                    for (int j = 0; j < count; j++) {
                        free(result[j]);
                    }
                    free(result);
                    free(orderedQuantities);
                    *returnSize = 0;
                    return NULL;
                }
                count++;
            }
        }
    }

    // Free the temporary array used for summing ordered quantities.
    free(orderedQuantities);

    *returnSize = count; // Set the actual number of results found.

    // If no books were found, free the initially allocated `result` array.
    if (count == 0) {
        free(result);
        return NULL;
    }

    // Reallocate `result` to the exact size needed to save memory.
    // If `realloc` fails, it returns NULL, and the original `result` pointer remains valid.
    // In such a case, we return the original (potentially over-allocated) array.
    char** finalResult = (char**)realloc(result, count * sizeof(char*));
    if (!finalResult) {
        // If realloc failed, return the original `result` array.
        return result;
    }

    return finalResult;
}