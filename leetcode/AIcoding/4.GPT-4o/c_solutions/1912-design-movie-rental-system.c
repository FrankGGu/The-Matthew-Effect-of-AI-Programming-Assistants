#define MAX_MOVIES 1000
#define MAX_CUSTOMERS 1000

typedef struct {
    int id;
    int available;
} Movie;

typedef struct {
    int id;
    int rented;
} Customer;

typedef struct {
    Movie movies[MAX_MOVIES];
    Customer customers[MAX_CUSTOMERS];
    int movieCount;
    int customerCount;
} MovieRentalSystem;

MovieRentalSystem* movieRentalSystemCreate(int* movie_ids, int movie_idsSize, int* customer_ids, int customer_idsSize) {
    MovieRentalSystem* system = (MovieRentalSystem*)malloc(sizeof(MovieRentalSystem));
    system->movieCount = movie_idsSize;
    system->customerCount = customer_idsSize;
    for (int i = 0; i < movie_idsSize; i++) {
        system->movies[i].id = movie_ids[i];
        system->movies[i].available = 1;
    }
    for (int i = 0; i < customer_idsSize; i++) {
        system->customers[i].id = customer_ids[i];
        system->customers[i].rented = 0;
    }
    return system;
}

void movieRentalSystemRent(MovieRentalSystem* obj, int movie_id, int customer_id) {
    for (int i = 0; i < obj->movieCount; i++) {
        if (obj->movies[i].id == movie_id && obj->movies[i].available) {
            obj->movies[i].available = 0;
            for (int j = 0; j < obj->customerCount; j++) {
                if (obj->customers[j].id == customer_id) {
                    obj->customers[j].rented = 1;
                    break;
                }
            }
            break;
        }
    }
}

void movieRentalSystemReturn(MovieRentalSystem* obj, int movie_id, int customer_id) {
    for (int i = 0; i < obj->movieCount; i++) {
        if (obj->movies[i].id == movie_id) {
            obj->movies[i].available = 1;
            for (int j = 0; j < obj->customerCount; j++) {
                if (obj->customers[j].id == customer_id) {
                    obj->customers[j].rented = 0;
                    break;
                }
            }
            break;
        }
    }
}

void movieRentalSystemFree(MovieRentalSystem* obj) {
    free(obj);
}