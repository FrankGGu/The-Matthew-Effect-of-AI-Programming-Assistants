use std::sync::{Arc, Mutex};
use std::sync::mpsc::{Sender, Receiver, channel};
use std::thread;

struct TrafficLight {
    state: Arc<Mutex<i32>>,
    tx: Sender<i32>,
    rx: Receiver<i32>,
}

impl TrafficLight {
    fn new() -> Self {
        let (tx, rx) = channel();
        TrafficLight {
            state: Arc::new(Mutex::new(1)),
            tx,
            rx,
        }
    }

    fn car_arrived(&self, car_id: i32, road_id: i32, direction: i32, turn_green: impl Fn() + Send + 'static) {
        let mut state = self.state.lock().unwrap();
        if *state != road_id {
            turn_green();
            *state = road_id;
        }
        println!("Car {} has passed road {}", car_id, road_id);
        self.tx.send(car_id).unwrap();
    }
}