#include <math.h>
#include <stdlib.h>
#include <string.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define EPSILON 1e-9

typedef struct {
    double angle;
    int type; // +1 for start of interval, -1 for end
} Event;

int compareEvents(const void* a, const void* b) {
    Event* eventA = (Event*)a;
    Event* eventB = (Event*)b;

    if (fabs(eventA->angle - eventB->angle) < EPSILON) {
        // If angles are equal (within epsilon), process +1 events before -1 events
        return eventB->type - eventA->type;
    }
    return (eventA->angle < eventB->angle) ? -1 : 1;
}

int numPoints(int** points, int pointsSize, int* pointsColSize, int r) {
    if (pointsSize == 0) {
        return 0;
    }

    // Special handling for r = 0
    if (r == 0) {
        int max_identical = 0;
        for (int i = 0; i < pointsSize; ++i) {
            int current_identical = 1;
            for (int j = i + 1; j < pointsSize; ++j) {
                if (points[i][0] == points[j][0] && points[i][1] == points[j][1]) {
                    current_identical++;
                }
            }
            max_identical = (max_identical > current_identical) ? max_identical : current_identical;
        }
        return max_identical;
    }

    int max_moles = 1; // At least one mole can be hit if pointsSize >= 1

    // Allocate memory for events. Maximum (pointsSize - 1) * 4 events in worst case
    // (each point pair can generate an interval that splits across -PI/PI boundary,
    // resulting in 4 events).
    Event* events = (Event*)malloc(sizeof(Event) * (pointsSize - 1) * 4);
    if (!events) {
        return 0; // Allocation failed
    }

    for (int i = 0; i < pointsSize; ++i) {
        int px = points[i][0];
        int py = points[i][1];

        int event_count = 0;

        for (int j = 0; j < pointsSize; ++j) {
            if (i == j) {
                continue;
            }

            int qx = points[j][0];
            int qy = points[j][1];

            double dx = (double)qx - px;
            double dy = (double)qy - py;

            double d_sq = dx * dx + dy * dy;
            double r_sq = (double)r * r;

            // If P_j is very close to P_i (d_sq approx 0), it's considered identical.
            // Such a point is always covered if P_i is on the circumference,
            // and it doesn't restrict the center's position on P_i's circle.
            // So, we count it in the initial overlap and skip adding events.
            if (d_sq < EPSILON) {
                continue;
            }

            // If distance between P_i and P_j is greater than 2*r,
            // P_j cannot be covered by a circle of radius r whose circumference passes through P_i.
            // Add EPSILON to 4.0 * r_sq to handle floating point inaccuracies where d_sq might be
            // slightly larger than 4*r_sq but should be considered within range.
            if (d_sq > 4.0 * r_sq + EPSILON) { 
                continue;
            }

            double d = sqrt(d_sq);
            double alpha = atan2(dy, dx); // Angle of vector P_i -> P_j

            // beta is half the angle subtended by P_iP_j at the center of the circle.
            // cos(beta) = (d/2) / r
            // d / (2.0 * r) can be slightly > 1 due to precision errors if d is very close to 2r.
            // Clamp it to [-1, 1] for acos.
            double cos_beta_val = d / (2.0 * r);
            if (cos_beta_val > 1.0) cos_beta_val = 1.0;
            if (cos_beta_val < -1.0) cos_beta_val = -1.0;

            double beta = acos(cos_beta_val);

            double start_angle = alpha - beta;
            double end_angle = alpha + beta;

            // If the interval crosses the -PI/PI boundary, split it into two events.
            if (start_angle > end_angle) {
                events[event_count++] = (Event){start_angle, 1};
                events[event_count++] = (Event){M_PI, -1}; // End of first part
                events[event_count++] = (Event){-M_PI, 1}; // Start of second part
                events[event_count++] = (Event){end_angle, -1};
            } else {
                events[event_count++] = (Event){start_angle, 1};
                events[event_count++] = (Event){end_angle, -1};
            }
        }

        // Sort events
        qsort(events, event_count, sizeof(Event), compareEvents);

        // Initial count: P_i itself, plus any points identical to P_i
        int current_overlap = 1; 
        for (int k = 0; k < pointsSize; ++k) {
            if (i == k) continue;
            if (points[i][0] == points[k][0] && points[i][1] == points[k][1]) {
                current_overlap++;
            }
        }

        max_moles = (max_moles > current_overlap) ? max_moles : current_overlap;

        for (int k = 0; k < event_count; ++k) {
            current_overlap += events[k].type;
            max_moles = (max_moles > current_overlap) ? max_moles : current_overlap;
        }
    }

    free(events);
    return max_moles;
}