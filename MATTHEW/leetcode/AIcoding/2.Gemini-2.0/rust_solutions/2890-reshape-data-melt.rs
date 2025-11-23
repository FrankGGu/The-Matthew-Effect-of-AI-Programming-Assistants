use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct Dataframe {
    pub data: HashMap<String, Vec<i32>>,
}

impl Dataframe {
    pub fn new(data: HashMap<String, Vec<i32>>) -> Self {
        Dataframe { data }
    }
}

pub fn melt(dataframe: Dataframe, melt_vars: Vec<String>) -> Dataframe {
    let mut id_vars: Vec<String> = dataframe.data.keys().cloned().collect();
    id_vars.retain(|x| !melt_vars.contains(x));

    let mut variable: Vec<String> = Vec::new();
    let mut value: Vec<i32> = Vec::new();

    let n = dataframe.data[&id_vars[0]].len();

    for i in 0..n {
        for melt_var in &melt_vars {
            variable.push(melt_var.clone());
            value.push(dataframe.data[melt_var][i]);
        }
    }

    let mut new_data: HashMap<String, Vec<i32>> = HashMap::new();

    for id_var in &id_vars {
        let mut id_var_values: Vec<i32> = Vec::new();
        for i in 0..n {
            for _ in &melt_vars {
                id_var_values.push(dataframe.data[id_var][i]);
            }
        }
        new_data.insert(id_var.clone(), id_var_values);
    }

    new_data.insert("variable".to_string(), variable);
    new_data.insert("value".to_string(), value);

    Dataframe::new(new_data)
}