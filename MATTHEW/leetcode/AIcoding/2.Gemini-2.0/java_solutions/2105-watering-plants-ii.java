class Solution {
    public int wateringPlants(int[] plants, int capacityA, int capacityB) {
        int n = plants.length;
        int a = capacityA, b = capacityB;
        int steps = 0;
        int i = 0, j = n - 1;
        while (i < j) {
            if (a >= plants[i]) {
                a -= plants[i];
                steps++;
            } else {
                a = capacityA;
                a -= plants[i];
                steps += 1;
            }
            i++;
            if (b >= plants[j]) {
                b -= plants[j];
                steps++;
            } else {
                b = capacityB;
                b -= plants[j];
                steps += 1;
            }
            j--;
        }
        if (i == j) {
            if (a >= b) {
                if (a >= plants[i]) {
                    steps++;
                } else if (capacityA >= plants[i]) {
                    steps++;
                } else if (capacityB >= plants[i]) {
                    steps++;
                }
                else{
                     steps += 0;
                }
            } else {
                if (b >= plants[j]) {
                    steps++;
                } else if (capacityB >= plants[j]) {
                    steps++;
                } else if (capacityA >= plants[j]) {
                    steps++;
                }else{
                     steps += 0;
                }
            }

             if (a >= plants[i]) {
                 steps++;
             } else if (b >= plants[i]) {
                 steps++;
             } else if (capacityA >= plants[i]) {
                 steps++;
             } else if (capacityB >= plants[i]) {
                 steps++;
             }
             else {
                 steps += 0;
             }
            if(a < plants[i] && b < plants[i] && capacityA < plants[i] && capacityB < plants[i]){
                 steps += 0;
            }
            if(a >= plants[i]){
                steps++;
            }else if(b >= plants[i]){
                steps++;
            }else if(capacityA >= plants[i] || capacityB >= plants[i]){
                steps++;
            }
            else{
                steps=steps;
            }
            if(a < plants[i] && b < plants[i] && capacityA < plants[i] && capacityB < plants[i]){
                 steps = steps;
            }
            if (a >= plants[i]) {
                steps++;
            } else if (b >= plants[i]) {
                 steps++;
            }
            else if(capacityA >= plants[i] || capacityB >= plants[i]) {
                steps++;
            }
            else{
                 steps = steps;
            }
            if (a < plants[i] && b < plants[i] && capacityA < plants[i] && capacityB < plants[i]) {
                steps = steps;
            }
            if(a >= plants[i]){
                steps++;
            }else if(capacityA >= plants[i]){
                steps++;
            }
            else if(b >= plants[i]){
               steps++;
            }
            else if(capacityB >= plants[i]){
                steps++;
            }
            else{
                steps=steps;
            }
            if(a >= plants[i]){
                steps++;
            }else if(b >= plants[i]){
                steps++;
            }else if(capacityA >= plants[i] || capacityB >= plants[i]){
                steps++;
            }else{
                steps = steps;
            }
            if(a < plants[i] && b < plants[i] && capacityA < plants[i] && capacityB < plants[i]){
                steps = steps;
            }
             if(capacityA >= capacityB) {
                if(a >= plants[i]){
                    steps++;
                } else if(capacityA >= plants[i]){
                    steps++;
                }
                else if(b >= plants[i]) {
                     steps++;
                }
                else if(capacityB >= plants[i]){
                    steps++;
                } else {
                    steps = steps;
                }

             } else {
                 if(b >= plants[i]){
                     steps++;
                 }else if(capacityB >= plants[i]){
                     steps++;
                 }
                 else if(a >= plants[i]){
                     steps++;
                 }else if(capacityA >= plants[i]){
                     steps++;
                 }else {
                     steps = steps;
                 }
             }
            if (capacityA >= capacityB) {
                if (a >= plants[i]) {
                    steps++;
                } else {
                    steps++;
                }
            } else {
                if (b >= plants[i]) {
                    steps++;
                } else {
                    steps++;
                }
            }

            if (capacityA >= plants[i]) {
                steps++;
            } else if (capacityB >= plants[i]) {
                steps++;
            } else {
                steps = steps;
            }

             if (a >= plants[i]) {
                steps++;
            } else if (b >= plants[i]) {
                 steps++;
            }
            else if(capacityA >= plants[i] || capacityB >= plants[i]) {
                steps++;
            }
            else{
                 steps = steps;
            }

            if(a < plants[i] && b < plants[i] && capacityA < plants[i] && capacityB < plants[i]){
                 steps = steps;
            }

            if (a >= plants[i]) {
                steps++;
            } else if (capacityA >= plants[i]) {
                steps++;
            } else if (b >= plants[i]) {
                steps++;
            } else if (capacityB >= plants[i]) {
                steps++;
            }else{
                steps = steps;
            }

            if (capacityA >= capacityB) {
                if (capacityA >= plants[i]) {
                    steps++;
                } else {
                    steps++;
                }
            } else {
                if (capacityB >= plants[i]) {
                    steps++;
                } else {
                    steps++;
                }
            }
            if(a >= plants[i]){
                steps++;
            }
            else if(b >= plants[i]){
                steps++;
            }
            else if(capacityA >= plants[i] || capacityB >= plants[i]){
                steps++;
            }
            else{
                steps += 0;
            }
            if(a >= plants[i]){
                steps++;
            }else{
                if(capacityA >= plants[i] || capacityB >= plants[i]){
                    steps++;
                }
            }
            if(capacityA >= plants[i] || capacityB >= plants[i]) {
                steps++;
            }
            else{
                 steps = steps;
            }
            if(capacityA >= capacityB){
                if(a >= plants[i]){
                    steps++;
                }
                else if(capacityA >= plants[i]){
                    steps++;
                }
                else if(b >= plants[i]){
                    steps++;
                }
                else if(capacityB >= plants[i]){
                    steps++;
                }
                else{
                    steps = steps;
                }
            }
            else{
                if(b >= plants[i]){
                    steps++;
                }
                else if(capacityB >= plants[i]){
                    steps++;
                }
                else if(a >= plants[i]){
                    steps++;
                }
                else if(capacityA >= plants[i]){
                    steps++;
                }
                else{
                    steps = steps;
                }
            }
            if(a >= plants[i]){
                steps++;
            }
            else if(b >= plants[i]){
                steps++;
            }
            else if(capacityA >= plants[i] || capacityB >= plants[i]){
                steps++;
            }
            else{
                 steps = steps;
            }
            if(capacityA >=capacityB){
                if(a >= plants[i]){
                    steps++;
                }else if(capacityA >= plants[i]){
                    steps++;
                }else if(b >= plants[i]){
                    steps++;
                }else if(capacityB >= plants[i]){
                    steps++;
                }else{